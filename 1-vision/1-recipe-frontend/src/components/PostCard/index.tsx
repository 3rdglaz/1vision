import { Avatar, Grid } from "@mui/material";
import {
  Translate,
  TimerOutlined,
  ExpandMore,
  Star,
  StarOutline,
} from "@mui/icons-material";
import {
  StyledChip,
  StyledGrid,
  StyledImage,
  StyledLikes,
  StyledTitle,
} from "./styles";
import { StyledButton } from "@/shared/Button";
import { StyledDivider } from "@/shared/Divider";

type Props = {
  user: string;
  image: string;
  title: string;
  rating: number;
  likes: number;
  time: string;
  tags: string[];
};

export const PostCard = (props: Props) => {
  return (
    <StyledGrid container padding={3}>
      <Grid item xs={12} container>
        <Avatar sx={{ width: 32, height: 32, marginRight: 1.5 }} />
        <StyledTitle fontWeight="600">{props.user}</StyledTitle>
      </Grid>
      <Grid item xs={12}>
        <StyledImage width={600} height={400} src={props.image} alt="recipe" />
        <StyledTitle fontWeight="700">{props.title}</StyledTitle>
      </Grid>
      <Grid item xs={12} container margin="14px 0" alignItems="center">
        {Array.from(Array(5)).map((_, i) => {
          const Icon = i < props.rating ? Star : StarOutline;
          const marginRight = i == 4 ? "34px" : "12px";
          return (
            <Icon
              key={i.toString()}
              color="secondary"
              sx={{
                marginRight,
                fontSize: "24px",
              }}
            />
          );
        })}
        <StyledLikes>{props.likes} Likes</StyledLikes>
      </Grid>
      <Grid item xs={12} container>
        <StyledChip
          icon={<TimerOutlined />}
          label={props.time}
          variant="outlined"
        />
        {props.tags.map((t, i) => (
          <StyledChip key={i.toString()} label={t} variant="outlined" />
        ))}
      </Grid>
      <StyledDivider margin="24px 0" />
      <Grid item xs={12} container justifyContent="flex-end">
        <StyledButton
          width={206}
          startIcon={<Translate />}
          endIcon={<ExpandMore />}
          variant="contained"
        >
          Translate recipe
        </StyledButton>
      </Grid>
    </StyledGrid>
  );
};
